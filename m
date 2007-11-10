From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Fri, 09 Nov 2007 22:05:05 -0500
Message-ID: <47351FE1.4000001@garzik.org>
References: <20071109020235.GA2031@ceren>	<20071109023129.GA25581@havoc.gtf.org>	<4733D421.7000505@rtr.ca>	<20071109034622.GB25581@havoc.gtf.org> <20071109120425.543971bf@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763452AbXKJDF3@vger.kernel.org>
In-Reply-To: <20071109120425.543971bf@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Thu, 8 Nov 2007 22:46:22 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> On Thu, Nov 08, 2007 at 10:29:37PM -0500, Mark Lord wrote:
>>> And I might even privately patch my own kernels to map the ACHI BAR
>>> in the cases where the BIOS didn't...
>> The inability to do this in the general case is the main reason why
>> AHCI was not unconditionally enabled, even in IDE mode, when it was
>> originally added...  :/
> 
> We've done it all the time for various devices without problems (eg S3
> video cards). I'd like to see it go in - although perhaps attached to a
> force_ahci boot param initially

By forcing AHCI, your PATA devices will be inaccessible, in a common 
configuration.  It also means shuffling users from one driver to 
another, which induces breakage.

I was speaking wishfully.  Real life intrudes, alas.

	Jeff
