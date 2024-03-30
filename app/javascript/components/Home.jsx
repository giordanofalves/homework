import React, { useEffect, useState, useCallback} from "react";
import { throttle } from 'lodash';


export default () => {
  // List of fetched companies AND industries
  const [companies, setCompanies] = useState([]);
  const [industries, setIndustries] = useState([]);

  // Pagination
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(0);

  // Table filters
  const [companyName, setCompanyName] = useState("");
  const [industry, setIndustry] = useState("");
  const [minEmployee, setMinEmployee] = useState("");
  const [minimumDealAmount, setMinimumDealAmount] = useState("");
  const [message, setMessage] = useState("");

  // Fetch companies from API
  const fetchCompanies = useCallback(throttle((name, industry, minimum_employee_count, minimum_deals_amount, page) => {
    let filters = {
      name: name,
      industry: industry,
      minimum_employee_count: minimum_employee_count,
      minimum_deals_amount: parseFloat(minimum_deals_amount) || minimum_deals_amount,
      page: page
    };

    const url = "/api/v1/companies?" + new URLSearchParams(filters);

    fetch(url)
      .then((res) => {
        if (!res.ok) {
          throw new Error(`HTTP error! status: ${res.status}`);
        }
        return res.json();
      })
      .then((res) => {
        setCompanies(res["companies"]);
        setCurrentPage(res.current_page);
        setTotalPages(res.total_pages);
        setMessage("");
      }).catch((error) => {
        setCompanies([]);
        if (error.message.includes("404")) {
          setMessage("No data found with those filters, please check your search criteria and try again.");
        } else {
          setMessage("An error occurred while filtering companies, please check your search criteria and try again.");
        }
      });
  }, 1000), []);

  useEffect(() => {
    fetchCompanies(companyName, industry, minEmployee, minimumDealAmount, currentPage);
  }, [companyName, industry, minEmployee, minimumDealAmount, currentPage])


  // Fetch industries from API
  useEffect(() => {
    const url = "/api/v1/companies/list_industries";

    fetch(url)
      .then((res) => {
        return res.json();
      })
      .then((res) => setIndustries(res["industries"]))
  }, []);

  const handlePrevPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
  };

  const handleNextPage = () => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    }
  };

  return (
    <div className="vw-100 primary-color d-flex align-items-center justify-content-center">
      <div className="jumbotron jumbotron-fluid bg-transparent">
        <div className="container secondary-color">
          <h1 className="display-4">Companies</h1>

          <label htmlFor="company-name">Company Name</label>
          <div className="input-group mb-3">
            <input type="text" className="form-control" id="company-name" value={companyName} onChange={e => { setCompanyName(e.target.value); setCurrentPage(1); }} />
          </div>

          <label htmlFor="industry">Industry</label>
          <div className="input-group mb-3">
            <select className="form-control" id="industry" value={industry} onChange={e => { setIndustry(e.target.value); setCurrentPage(1); }}>
              <option value="">Select an industry</option>
              {industries.map((industry, index) => (
                <option key={index} value={industry}>{industry}</option>
              ))}
            </select>
          </div>

          <label htmlFor="min-employee">Minimum Employee Count</label>
          <div className="input-group mb-3">
            <input type="text" className="form-control" id="min-employee" value={minEmployee} onChange={e => { setMinEmployee(e.target.value); setCurrentPage(1);}} />
          </div>

          <label htmlFor="min-amount">Minimum Deal Amount</label>
          <div className="input-group mb-3">
            <input type="text" className="form-control" id="min-amount" value={minimumDealAmount} onChange={e => { setMinimumDealAmount(e.target.value); setCurrentPage(1); }} />
          </div>

          <table className="table">
            <thead>
              <tr>
                <th scope="col">Name</th>
                <th scope="col">Industry</th>
                <th scope="col">Employee Count</th>
                <th scope="col">Total Deal Amount</th>
              </tr>
            </thead>
            <tbody>
              {companies.map((company) => (
                <tr key={company.id}>
                  <td>{company.name}</td>
                  <td>{company.industry}</td>
                  <td>{company.employee_count}</td>
                  <td>{company.deals_amount}</td>
                </tr>
              ))}
            </tbody>
          </table>
          <p>{message}</p>
          <button onClick={handlePrevPage} disabled={currentPage === 1}>Previous</button>
          <span>{currentPage} of {totalPages}</span>
          <button onClick={handleNextPage} disabled={currentPage === totalPages}>Next</button>
        </div>
      </div>
    </div>
  )
};
