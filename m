From: Mark Lord <liml@rtr.ca>
Subject: Re: ICH Intel PATA short cable override...
Date: Mon, 10 Sep 2007 08:15:16 -0400
Message-ID: <46E53554.1090604@rtr.ca>
References: <6278d2220709040537n4c96ffcagd9c25c94ddd29ca1@mail.gmail.com> <20070906014209.142382c8@the-village.bc.nu> <46DF63F8.8070805@rtr.ca> <46E1DC6E.9060001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933265AbXIJMPb@vger.kernel.org>
In-Reply-To: <46E1DC6E.9060001@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel J Blueman <daniel.blueman@gmail.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>> Ditto for selecting transfer modes.
> 
> 
> Waiting on one thing AFAICS:
> 
>     ability to drain/idle all ports +
>     issue a command on one port +
>     resume normal parallel port operation
> 
> SET FEATURES - XFER MODE is special in that it requires all sorts of 
> additional controller handling and careful cross-port synchronization.

Absolutely.

Also note that I'm *not* advocating HDIO_SET_PIO_MODE (and kin) here,
but rather perhaps a sysfs option per-drive.  It is needed, especially for
custom/embedded systems, and I suppose we will get there eventually.  :)

Cheers
