From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libata: implement libata.force_cbl parameter
Date: Wed, 09 Jan 2008 10:19:59 +0900
Message-ID: <4784213F.4070203@gmail.com>
References: <4783786A.6040608@gmail.com> <20080108144004.30a18457@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:45596 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757828AbYAIBUH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 20:20:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so39989rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 17:20:05 -0800 (PST)
In-Reply-To: <20080108144004.30a18457@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Tue, 08 Jan 2008 22:19:38 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Implement libata.force_cbl parameter to work around incorrect PATA
>> cable detection.
> 
> This seems to be a pretty hopeless hack as it assumes all your devices
> are on the same cable (most boxes now have SATA and PATA). If we are
> going to do this we need a way to specify which controller/device as we
> will do for geometry forcing and other stuff.

This only forces PATA controllers to certain cable type.  It's a last
resort method for installation or live media - just enough to get things
going.

-- 
tejun
