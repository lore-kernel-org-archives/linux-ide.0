From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's in libata-dev.git
Date: Wed, 13 Sep 2006 10:50:28 +0900
Message-ID: <450763E4.6010602@gmail.com>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <4505694D.5020304@garzik.org> <Pine.LNX.4.64.0609110749410.27779@g5.osdl.org> <45067312.7020900@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:55648 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751486AbWIMBuz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Sep 2006 21:50:55 -0400
Received: by nz-out-0102.google.com with SMTP id n1so864771nzf
        for <linux-ide@vger.kernel.org>; Tue, 12 Sep 2006 18:50:54 -0700 (PDT)
In-Reply-To: <45067312.7020900@aitel.hist.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Helge Hafting wrote:
> How about a simple and harmless test?
> When an IDE disk is accessed for the first time, perhaps when
> the partition table is read - issue a 256-sector read and see
> what happens.  If it works - fine.  If not, tag the thing as
> supporting max 255 sectors.
> 
> No wrecking of file systems, and full performance for
> the vast majority.

Before implementing anything like that, we need a test case.  We don't 
know how a faulty drive reacts on such cases.  If it actively aborts the 
command, we can reduce the limit to 255 sectors after upper layer issues 
such command, no need to do it earlier.  If it times out, we can't do it 
during boot and it will suck later too.  If it silently corrupts data 
(highly unlikely), we need to detect the condition during boot.

I don't think it matters all that much anyway.  IDE has been running w/ 
256 sectors for a loooong time and someone who seeks performance from 
LBA28 only drive has bigger problems (also I don't think 255 would be 
noticeably slower than 256).

-- 
tejun
