From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ahci: avoton port-disable reset-quirk
Date: Sun, 10 May 2015 11:42:28 -0400
Message-ID: <20150510154228.GB5856@htj.duckdns.org>
References: <20150508192113.33528.60893.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150508192113.33528.60893.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: stable-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, May 08, 2015 at 03:23:55PM -0400, Dan Williams wrote:
> Avoton AHCI occasionally sees drive probe timeouts at driver load time.
> When this happens SCR_STATUS indicates device detected, but no D2H FIS
> reception.  Reset the internal link state machines by bouncing
> port-enable in the PCS register when this occurs.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied to libata/for-4.1-fixes.

Thanks.

-- 
tejun
