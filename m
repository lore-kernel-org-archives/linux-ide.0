From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] pata_marvell: fix cable detection - take 2
Date: Mon, 20 Nov 2006 15:42:18 -0500
Message-ID: <20061120204218.GC24922@devserv.devel.redhat.com>
References: <m3psbhdg4j.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:19076 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966669AbWKTUmU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Nov 2006 15:42:20 -0500
Content-Disposition: inline
In-Reply-To: <m3psbhdg4j.fsf@anduin.mandriva.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: linux-ide@vger.kernel.org, alan@redhat.com

On Mon, Nov 20, 2006 at 09:20:44PM +0100, Arnaud Patard wrote:
> 
> Last time I looked at the cable detection code, I fixed the "always
> detect cable as sata cable" case, but this is not enough. I didn't
> notice that the 80-pin cable was seen as a 40-pin cable.
> The appended patch fixes that.

Thanks - the docs were a bit blank on which was which - have you checked
this now detects right both ways around ?
