From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Thu, 10 Jan 2008 12:29:54 +0900
Message-ID: <47859132.1000700@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com> <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:11817 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215AbYAJDaB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 22:30:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so803332wah.23
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 19:30:00 -0800 (PST)
In-Reply-To: <47845F91.9000705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>, "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Please apply the attached patch on top of 2.6.24-rc7 and report the
> result.  Thanks.

Andrew, with the patch applied, please try to turn off and on the PMP
array while the system is running and verify that each time the array
gets detected correctly and disks are accessible.

Thanks.

-- 
tejun
