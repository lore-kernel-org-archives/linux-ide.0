From: Wayne Sherman <Wayne@SystemDesignWorks.com>
Subject: Re: AHCI support on Intel chipsets (confusion?)
Date: Sat, 02 Dec 2006 02:53:45 -0800
Message-ID: <45715B39.1000101@SystemDesignWorks.com>
References: <45715381.80206@SystemDesignWorks.com> <c384c5ea0612020232n3d33cfady627987e98957d495@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ev1s-69-57-152-63.ev1servers.net ([69.57.152.63]:43431 "EHLO
	server.monsterhosting.org") by vger.kernel.org with ESMTP
	id S1759445AbWLBKxs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Dec 2006 05:53:48 -0500
In-Reply-To: <c384c5ea0612020232n3d33cfady627987e98957d495@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Leon,

Leon Woestenberg wrote:
> We (yesterday) found out that our board (a Supermicro PDSMI+, ICH7 as
> well) needs the proper BIOS setting in order for it to appear as a
> AHCI capable controller.

I just checked your motherboard:

http://www.supermicro.com/products/motherboard/Xeon3000/3000/PDSMi+.cfm

It uses an ICH7R, and according to the Intel page that one *DOES* 
supports AHCI.

Regards,

Wayne
