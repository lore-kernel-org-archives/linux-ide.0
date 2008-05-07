From: "Bart Van Assche" <bart.vanassche@gmail.com>
Subject: Re: Compact Flash Question
Date: Wed, 7 May 2008 09:58:56 +0200
Message-ID: <e2e108260805070058p476901f5ta4c38e99e1421eec@mail.gmail.com>
References: <48215673.3060201@wpkg.org>
	 <e2e108260805070044v42f596bbj39c5b52b6f0a096@mail.gmail.com>
	 <48216039.3070001@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:26598 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbYEGH66 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 03:58:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so146097fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 07 May 2008 00:58:56 -0700 (PDT)
In-Reply-To: <48216039.3070001@wpkg.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, YSadgat1@gcte.com, linux-os@analogic.com, Alan <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

On Wed, May 7, 2008 at 9:54 AM, Tomasz Chmielewski <mangoo@wpkg.org> wrote:
> How does it work, then?
> How can it do wear levelling over the whole CF if some (or most) area of CF
> is already used by our precious data/metadata?
> It would have to know the areas where no data is stored, but it contradicts
> the CF <-> filesystem separation.

The wear leveling algorithm even works if the CompactFlash controller
has no knowledge of the sectors on which filesystem data is stored.
All that is needed is some spare space on the CompactFlash that is not
made visible through the IDE interface, a controller that is able to
remap sectors and that stores this mapping persistently.

Bart.
