From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 13:48:32 -0500
Message-ID: <4D52E180.6020908@garzik.org>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <20110209153601.GJ3770@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57613 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab1BISsh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 13:48:37 -0500
Received: by vws16 with SMTP id 16so298055vws.19
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2011 10:48:36 -0800 (PST)
In-Reply-To: <20110209153601.GJ3770@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Phillip Susi <psusi@cfl.rr.com>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 02/09/2011 10:36 AM, Tejun Heo wrote:
> Agreed.  We're screwed whether we unlock or leave it alone.  I think
> the best way is to export the original size via sysfs and always
> unlock and let dmraid and whatever stuff which expects metadata at the
> end use the bios size.

Agreed...

	Jeff



