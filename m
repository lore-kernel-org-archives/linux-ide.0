From: dean gaudet <dean@arctic.org>
Subject: Re: [PATCH, RFT, v4] sata_mv: convert to new EH
Date: Sat, 26 May 2007 00:53:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705252335590.8327@twinlark.arctic.org>
References: <20070225233454.GA31282@havoc.gtf.org>
 <1173158201.3416.8.camel@obelisk.thedillows.org>  <45ED039E.20608@garzik.org>
 <1173164261.3416.15.camel@obelisk.thedillows.org> <4656EB26.40504@garzik.org>
 <4657A678.8090308@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755666AbXEZHxS@vger.kernel.org>
In-Reply-To: <4657A678.8090308@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Dave Dillow <dave@thedillows.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Fri, 25 May 2007, Jeff Garzik wrote:

> Already uncovered and fixed a few bugs in v3.
> 
> Here's v4 of the sata_mv new-EH patch.

you asked for test results with 2.6.21.3 ... that seems to boot fine,
and i've tested reading from the disks only and it seems to be working
fine.  ditto for 2.6.22-rc3.

but 2.6.22-rc3 + your v4 patch fails... i'll send you the serial console
outputs offline.

-dean
