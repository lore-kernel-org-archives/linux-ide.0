From: Roberto Oppedisano <roppedisano@infracomspa.it>
Subject: Re: libata: cdrw/dvdrom disabed after s2ram (2.6.24-rc2)
Date: Fri, 09 Nov 2007 16:48:33 +0100
Message-ID: <47348151.3040202@infracomspa.it>
References: <4731C86B.1040704@infracomspa.it> <20071107121355.5eaf4496.akpm@linux-foundation.org> <47333CCF.1050403@infracomspa.it> <20071108094958.5c9b1b22.akpm@linux-foundation.org> <20071108180256.GB3491@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.infracomspa.it ([217.12.183.244]:2257 "EHLO
	svkmg019i.infracomspa.it" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752807AbXKIPsk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 10:48:40 -0500
In-Reply-To: <20071108180256.GB3491@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Jeff Garzik wrote, On 11/08/2007 07:02 PM:
> Set module option "noacpi" to 1, to disable ACPI and see if that fixes
> the problem.
>   
Booting with libata.noacpi=1 fixes the problem too.

R
