From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: Compact Flash Question
Date: Wed, 07 May 2008 09:54:33 +0200
Message-ID: <48216039.3070001@wpkg.org>
References: <48215673.3060201@wpkg.org> <e2e108260805070044v42f596bbj39c5b52b6f0a096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:37433 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYEGHym (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 03:54:42 -0400
In-Reply-To: <e2e108260805070044v42f596bbj39c5b52b6f0a096@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, YSadgat1@gcte.com, linux-os@analogic.com, Alan <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

Bart Van Assche schrieb:
> On Wed, May 7, 2008 at 9:12 AM, Tomasz Chmielewski <mangoo@wpkg.org> wrote:
>> As Compact Flash and its wear levelling does not know about free space on
>> the filesystem, the wear levelling's effectiveness can be only limited -
>> writes won't spread on the whole free area of the flash.
>>
>> Does anyone know how wear levelling is done in these devices? Perhaps it
>> will differ from a manufacturer to manufacturer, but I guess they have a
>> free area we normally use to store data, and some reserved area used just
>> for wear levelling and bad block handling, but that's just my guess.
> 
> The wear leveling algorithm depends on the CompactFlash manufacturer.
> Most manufacturers define a certain number of areas on a CompactFlash.
> Each area consists of two or more sectors which are counted in the
> total size of the CompactFlash, and one or more spare sectors. Wear
> leveling is carried out within an area by spreading writes over the
> sectors in an area. The controller in the CompactFlash stores the data
> about which sectors are used for storing which data persistently. I
> know of only one manufacturer who makes the CompactFlash controllers
> carry out wear leveling over the whole CompactFlash. 

How does it work, then?
How can it do wear levelling over the whole CF if some (or most) area of CF is 
already used by our precious data/metadata?
It would have to know the areas where no data is stored, but it contradicts the 
CF <-> filesystem separation.


-- 
Tomasz Chmielewski
http://wpkg.org
