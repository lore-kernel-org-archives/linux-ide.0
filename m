From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2] libata: blacklist Micron SSD
Date: Wed, 2 May 2018 22:59:50 +0100
Message-ID: <20180502215950.GA4621@sudip-laptop>
References: <20180429160138.11091-1-sudip.mukherjee@codethink.co.uk>
 <yq1r2mw83cu.fsf@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yq1r2mw83cu.fsf@oracle.com>
Sender: stable-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Martin,

On Mon, Apr 30, 2018 at 11:24:49PM -0400, Martin K. Petersen wrote:
> 
> Sudip,
> 
> > v1: Only M500IT MU01 was blacklisted.
> >
> > v2: Whitelist M500IT BG02 and M500DC and then blacklist all other Micron. 
> 
> I think my preference would be to blacklist M500IT with the MU01
> firmware (which Micron said was affected) and rely on the "Micron*"
> fallthrough further down for the rest.

This patch was based on your reply at:
https://www.spinics.net/lists/linux-ide/msg55370.html

> 
> I have not gotten firm confirmation on ZRAT behavior so for now we
> should probably just do:
> 
> + { "Micron_M500IT_*", "MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },

My v1 patch had only MU01 with ATA_HORKAGE_NO_NCQ_TRIM and
ATA_HORKAGE_ZERO_AFTER_TRIM. I am not very much confident on only
having ATA_HORKAGE_NO_NCQ_TRIM as we have seen huge regression due to
243918be6393 ("libata: Do not blacklist Micron M500DC"). Unless, Micron
confirms that it can only have 'ATA_HORKAGE_NO_NCQ_TRIM' I think we
should go for both. I don't think we should mark it as ZRAT supported,
(without Micron confirmation) and cause another regression.
My v1 patch is at https://patchwork.kernel.org/patch/10287605/
Do you want me to resend it again?
