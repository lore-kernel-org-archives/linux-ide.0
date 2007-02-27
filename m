From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Tue, 27 Feb 2007 14:16:33 +0000
Message-ID: <20070227141633.5453982c@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070226220152.GA29575@stusta.de>
	<Pine.SOC.4.64.0702271459040.8348@math>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.SOC.4.64.0702271459040.8348@math>
Sender: linux-acpi-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 27 Feb 2007 15:00:29 +0200 (EET)
Meelis Roos <mroos@linux.ee> wrote:

> > Subject    : ata-piix ACPI errors (40/80 pin cable mix)
> > References : http://lkml.org/lkml/2007/2/22/159
> > Submitter  : Meelis Roos <mroos@linux.ee>
> > Status     : unknown
> 
> Still appears, but this does not seem to be 40/80 pin cable problem to 
> be but rather ata-piix calling some acpi methods and this rulsts in acpi 
> errors.

There are two separate problems showing up in the one trace - broken ACPI
spew and wrong cable detect. I don't think they are related
