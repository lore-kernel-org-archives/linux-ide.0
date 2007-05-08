From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [git patches] libata reset sequence update
Date: Tue, 08 May 2007 10:33:57 -0500
Message-ID: <46409865.9010204@linux.vnet.ibm.com>
References: <20070508063820.GA13469@havoc.gtf.org>
Reply-To: brking@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934746AbXEHPpv@vger.kernel.org>
In-Reply-To: <20070508063820.GA13469@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@SteelEye.com>
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> This has been testing in -mm for a while, but I wanted to send it
> separated from the main libata update, since it has a chance of
> breakage.
> 
> Most notably, a cumulative timeout (deadline) helps the code from diving
> into overly-long reset sequences.
> 
> Please pull from 'reset-seq' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git reset-seq

James,

FYI - this means you'll probably want to revert this patch:

http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commitdiff;h=a6506b8e111c9bf9e430e32725b96c0688416c8e

-Brian
