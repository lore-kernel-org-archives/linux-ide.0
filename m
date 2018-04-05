From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] libata: blacklist Micron 500IT SSD with MU01 firmware
Date: Thu, 5 Apr 2018 21:32:39 +0100
Message-ID: <20180405203239.GA20090@sudip-laptop>
References: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
 <yq137106mo9.fsf@oracle.com>
 <20180316205559.GA29406@sudip-laptop>
 <yq1y3ir668q.fsf@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yq1y3ir668q.fsf@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Martin,

On Fri, Mar 16, 2018 at 05:49:25PM -0400, Martin K. Petersen wrote:
> 
> Sudip,
> 
> >> Any reason to believe this deficiency is limited to MU01 firmware?
> >
> > Not really. But we also use MG02 firmware and afaik, Micron has
> > confirmed that MG02 is a fixed one.  I have only mentioned MU01 as I
> > know it has the problem.
> 
> Let me ask...

Any reply from Micron yet?

It might be better and safe to blacklist all Micron SSDs except M500DC
and M500IT (with MG02 firmware) until Micron replies.

--
Regards
Sudip                                    
