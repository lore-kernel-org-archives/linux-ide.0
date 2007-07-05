From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: "libata ignore_hpa=1" doesn't wok on SATA ?
Date: Thu, 05 Jul 2007 13:46:01 -0400
Message-ID: <468D2E59.9000902@redhat.com>
References: <932011.56083.qm@web54504.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48504 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758076AbXGERqD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jul 2007 13:46:03 -0400
In-Reply-To: <932011.56083.qm@web54504.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yong Jung <yong_jk@yahoo.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/04/2007 08:00 PM, yong Jung wrote:
> Hi,
> .
> I would like to see the whole disk area and erase the
> hpa area in my desktop.
> At first I tried "setmax.c" program but it didn't work
> on SATA at least.
> So I upgraeded it to FC7 and added "libata
> ignore_hpa=1" option on boot command and
> /etc/modprobe.conf. 
> This option was accepted but still the kernel couldn't
> see the whole disk area even after reboot.

That's "libata.ignore_hpa=1"

