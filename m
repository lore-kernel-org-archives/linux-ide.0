From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/13] ata_piix: convert ata_piix to new probing mechanism
Date: Fri, 12 May 2006 01:13:45 +0900
Message-ID: <446362B9.7080302@gmail.com>
References: <11473615273443-git-send-email-htejun@gmail.com>	 <1147363104.26130.49.camel@localhost.localdomain> <41840b750605110908te0b0026l54e559a90854f887@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:38775 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030305AbWEKQNw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:13:52 -0400
Received: by wr-out-0506.google.com with SMTP id i12so401788wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:13:51 -0700 (PDT)
In-Reply-To: <41840b750605110908te0b0026l54e559a90854f887@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Shem Multinymous wrote:
> Hi Alan,
> 
> On 5/11/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> On Gwe, 2006-05-12 at 00:32 +0900, Tejun Heo wrote:
>> > Convert ata_piix to new probing mechanism.  Automatic hotplug is not
>> > supported due to hardware limitation (no PHY event interrupt), but
>> > warm plugging works.
>>
>> True for the SATA ports but don't try it on the PATA ones. The PATA side
>> requires the right buffers are present, and also in some situations that
>> IORDY is not in use before the unplug.
> 
> I'm not sure what you mean but the successful ThinkPad UltraBay
> hotplugging which I reported earlier is with PATA DVD and PATA HDD, on
> ICH6M with ata_piix. I tried it many times, with no problems or
> unexpected dmesg entries.
> 
> As mentioned, it takes an extra ACPI command to electrically turn off 
> the port.

Yeap, notebooks are special.  Those hotbays are equipped with special 
power/signal connectors, circuits and switches to prevent things from 
burning, but, in general, hot plugging/unplugging PATA devices can fry 
the device and the controller.

-- 
tejun
