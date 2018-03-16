From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] libata: blacklist Micron 500IT SSD with MU01 firmware
Date: Fri, 16 Mar 2018 20:55:59 +0000
Message-ID: <20180316205559.GA29406@sudip-laptop>
References: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
 <yq137106mo9.fsf@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yq137106mo9.fsf@oracle.com>
Sender: stable-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Martin,

On Fri, Mar 16, 2018 at 11:54:30AM -0400, Martin K. Petersen wrote:
> 
> Sudip,
> 
> > While whitelisting Micron M500DC drives, the tweaked blacklist entry
> > enabled queued TRIM from M500IT variants also. But these do not support
> > queued TRIM. And while using those SSDs with the latest kernel we have
> > seen errors and even the partition table getting corrupted.
> 
> > +	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
> > +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> 
> Any reason to believe this deficiency is limited to MU01 firmware?

Not really. But we also use MG02 firmware and afaik, Micron has
confirmed that MG02 is a fixed one.
I have only mentioned MU01 as I know it has the problem.
