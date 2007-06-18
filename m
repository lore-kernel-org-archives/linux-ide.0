From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 12:10:31 +0900
Message-ID: <4675F7A7.8000109@gmail.com>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <466FC901.4060907@effenberger.org> <46710DDC.1030900@gmail.com> <467122B8.1090206@effenberger.org> <467133D7.7070000@gmail.com> <46715ADB.4020202@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:3415 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbXFRDKg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Jun 2007 23:10:36 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1255195nzf
        for <linux-ide@vger.kernel.org>; Sun, 17 Jun 2007 20:10:35 -0700 (PDT)
In-Reply-To: <46715ADB.4020202@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

Florian Effenberger wrote:
> What power supply would you recommend for this type of disks? I think we
> got a 450W Enermax, IIRC.

Most power supplies should be able to do 4 disks without any problem
unless it's broken.

> What do you mean by "merged speed down fix"? Is your fix for the speed
> down logic implemented in the current kernel, so I don't have to patch
> anymore (except when I want to force 1.5Gbps right from the beginning)?

Yeap, kernel will automatically downgrade to 1.5Gbps after several failures.

-- 
tejun
