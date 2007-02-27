From: Meelis Roos <mroos@linux.ee>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Tue, 27 Feb 2007 15:00:29 +0200 (EET)
Message-ID: <Pine.SOC.4.64.0702271459040.8348@math>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
 <20070226220152.GA29575@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750733AbXB0NAd@vger.kernel.org>
In-Reply-To: <20070226220152.GA29575@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> Subject    : ata-piix ACPI errors (40/80 pin cable mix)
> References : http://lkml.org/lkml/2007/2/22/159
> Submitter  : Meelis Roos <mroos@linux.ee>
> Status     : unknown

Still appears, but this does not seem to be 40/80 pin cable problem to 
be but rather ata-piix calling some acpi methods and this rulsts in acpi 
errors.

-- 
Meelis Roos (mroos@linux.ee)
