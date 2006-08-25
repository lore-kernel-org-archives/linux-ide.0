From: Tejun Heo <htejun@gmail.com>
Subject: Re: Libata EH False Alarm (2.6.18-rc2)?
Date: Fri, 25 Aug 2006 23:54:23 +0900
Message-ID: <44EF0F1F.3050109@gmail.com>
References: <8202f4270608241242i7a4d2d0anc3f607dad7df0129@mail.gmail.com>	 <44EE0561.1030007@gmail.com>	 <8202f4270608241305n2e0d3e80q2bd377ae85d841bb@mail.gmail.com>	 <44EE0A42.4070104@gmail.com> <44EE0AE6.8070608@gmail.com> <8202f4270608250741l15047a96q544d38eebca8d57e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:26579 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030242AbWHYOy3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 10:54:29 -0400
Received: by py-out-1112.google.com with SMTP id t32so1316839pyc
        for <linux-ide@vger.kernel.org>; Fri, 25 Aug 2006 07:54:29 -0700 (PDT)
In-Reply-To: <8202f4270608250741l15047a96q544d38eebca8d57e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Fajun Chen wrote:
> Hi Tejun,
> 
> I tested your patch. No more EH alarms in dmesg during an overnight
> test.  One question I have is whether this fix will mask genuine
> failure.

No, you're experiencing a lot recoverable failures.  The reason can be 
anything - faulty drive, flakey cable, out-of-spec on-board trace, 
etc...  You probably want to solve the problem.

-- 
tejun
