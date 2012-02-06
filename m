From: Norbert Preining <preining@logic.at>
Subject: Re: Regression 3.2 -> 3.3-rc1 10 sec hang at boot and resume,
	COMRESET failed
Date: Mon, 6 Feb 2012 09:46:08 +0900
Message-ID: <20120206004608.GA9413@gamma.logic.tuwien.ac.at>
References: <20120202051258.GA15550@gamma.logic.tuwien.ac.at> <4F2A4B7E.2090503@linux.vnet.ibm.com> <1328231716.15079.15.camel@minggr> <1328242884.15079.22.camel@minggr> <20120203052452.GC24563@gamma.logic.tuwien.ac.at> <1328247269.15079.26.camel@minggr> <20120203054319.GA25510@gamma.logic.tuwien.ac.at> <1328257660.15079.30.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1328257660.15079.30.camel@minggr>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, jeff@garzik.org, Tejun Heo <tj@kernel.org>, "stern@rowland.harvard.edu >> Alan Stern" <stern@rowland.harvard.edu>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-ide@vger.kernel.org

Hi Lin,


sorry for the delay, weekend I was off ...

On Fr, 03 Feb 2012, Lin Ming wrote:
> > Confirmed. Reverted 7faa33da9b7 on top of 6c073a7ee250 made
> > the boot delay go away. dmesg from this boot attached.
> 
> Dig into the code, but I can't find where the problem is.
> 
> Anyway, does below DEBUG patch help?
> Let's always stop the engine during hard reset.

If you meant: 
  "Try that patch on top of HEAD *without* reverting 7faa33da9b7?"
then I can report that it does NOT help. With *only* this patch I still
get 10sec delay, and otherwise nothing changes.


Best wishes

Norbert
------------------------------------------------------------------------
Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan                                 TeX Live & Debian Developer
DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
------------------------------------------------------------------------
YESNABY (n.)
A 'yes, maybe' which means 'no'.
			--- Douglas Adams, The Meaning of Liff
