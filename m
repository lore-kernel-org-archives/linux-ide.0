From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA HDD password problem
Date: Sat, 08 Mar 2008 09:51:40 +0900
Message-ID: <47D1E31C.3020109@gmail.com>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA> <47CFBDB6.8040400@gmail.com> <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA> <47D0BC5A.9000208@gmail.com> <47D154F0.50607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:43720 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbYCHAvv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2008 19:51:51 -0500
Received: by wx-out-0506.google.com with SMTP id h31so824045wxd.4
        for <linux-ide@vger.kernel.org>; Fri, 07 Mar 2008 16:51:50 -0800 (PST)
In-Reply-To: <47D154F0.50607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
>>>  Hmm, if someone enable SSP in the drive after password unlock - does
>>> this mean that it will be unlocked forever ? Or drive can distinguish
>>> between power-on and hard-reset states ?
>>
>> SSP by default stays on, so once unlocked it will stay unlocked as long
>> as power stays applied.  On power loss, it gets locked again.  On
>> reboots, the BIOS can always lock it again if it wants to.
> ..
> 
> The problem here, is that SSP itself gets turned-OFF after COMMRESET.
> It does preserve settings over the COMMRESET, but it then has to be
> renewed (re-issued by the driver) for things to survive a subsequent
> COMMRESET after the first one.   This has to go into libata,
> as it's not something we can control entirely from hdparm.

The following is from ACS8 SSP feature set description.

  Software settings preservation may be enabled or disabled using SET
  FEATURES with a Count field of 06h. If a device supports software
  settings preservation, the feature shall be enabled by default.  See
  SATA 2.6 for more information.

And the following is from enable/disable SSP description (7.48.18.7).

  The enable/disable state for software settings preservation shall
  persist across software reset. The enable/disable state for software
  settings preservation shall be reset to its default state upon
  COMRESET. The host may disable software settings preservation in
  order to not preserve software settings across COMRESET.

So, the default state being enabled and COMRESET always returning it
to default.  I don't think libata needs to take further action.

Thanks.

-- 
tejun
