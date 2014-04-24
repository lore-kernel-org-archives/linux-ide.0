From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ahci: disable DEVSLP for Intel Valleyview
Date: Thu, 24 Apr 2014 10:26:58 -0400
Message-ID: <20140424142658.GA14460@htj.dyndns.org>
References: <1397626031-4064-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397626031-4064-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 15, 2014 at 10:27:11PM -0700, Jacob Pan wrote:
> On Intel Valleyview SoC, SATA device sleep is not reliable. When
> DEVSLP is attempted on certain SSDs, port_devslp write would fail
> and result in malfunction of AHCI controller. AHCI controller may
> be not shown in PCI enumeration after reset. Complete power source
> removal may be required to recover from this failure. So we blacklist
> this device and override host device reported capabilities such that
> device LPM will only attempt slumber but not DEVSLP.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
