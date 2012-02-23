From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH v2 0/3] ahci: fix boot/resume COMRESET failures
Date: Thu, 23 Feb 2012 09:02:40 +0900
Message-ID: <20120223000240.GA1931@gamma.logic.tuwien.ac.at>
References: <1329849524-23758-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1329849524-23758-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Lin Ming <ming.m.lin@intel.com>, "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Valdis Kletnieks <valdis.kletnieks@vt.edu>, "Rafael J . Wysocki" <rjw@sisk.pl>
List-Id: linux-ide@vger.kernel.org

On Di, 21 Feb 2012, Brian Norris wrote:
> This series addresses regression problems with
> 
>     commit 7faa33da9b7add01db9f1ad92c6a5d9145e940a7
>     ahci: start engine only during soft/hard resets
> 
> Because the fix provided by the above commit caused COMRESET failures and
> 10 second boot-time/resume-time hangs for certain DVD drives, we need to
> make the fix conditional to certain devices/platforms. Add a flag for this.

I confirm that these patches without the previous fix also 
fixes the regression I have seen. Thanks.

Best wishes

Norbert
------------------------------------------------------------------------
Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan                                 TeX Live & Debian Developer
DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
------------------------------------------------------------------------
SHIRMERS (pl.n.)
Tall young men who stand around smiling at weddings as if to suggest
that they know they bride reather well.
			--- Douglas Adams, The Meaning of Liff
