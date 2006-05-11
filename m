From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [PATCH 08/13] ata_piix: convert ata_piix to new probing mechanism
Date: Thu, 11 May 2006 19:08:00 +0300
Message-ID: <41840b750605110908te0b0026l54e559a90854f887@mail.gmail.com>
References: <11473615273443-git-send-email-htejun@gmail.com>
	 <1147363104.26130.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:9072 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030301AbWEKQIA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 May 2006 12:08:00 -0400
Received: by wr-out-0506.google.com with SMTP id i12so400544wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:08:00 -0700 (PDT)
In-Reply-To: <1147363104.26130.49.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Hi Alan,

On 5/11/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2006-05-12 at 00:32 +0900, Tejun Heo wrote:
> > Convert ata_piix to new probing mechanism.  Automatic hotplug is not
> > supported due to hardware limitation (no PHY event interrupt), but
> > warm plugging works.
>
> True for the SATA ports but don't try it on the PATA ones. The PATA side
> requires the right buffers are present, and also in some situations that
> IORDY is not in use before the unplug.

I'm not sure what you mean but the successful ThinkPad UltraBay
hotplugging which I reported earlier is with PATA DVD and PATA HDD, on
ICH6M with ata_piix. I tried it many times, with no problems or
unexpected dmesg entries.

As mentioned, it takes an extra ACPI command to electrically turn off the port.

  Shem
