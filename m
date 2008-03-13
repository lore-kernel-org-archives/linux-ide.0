From: "Richard Genoud" <richard.genoud@gmail.com>
Subject: Re: [BUG] PLEXTOR DVDR PX-740A drive not ready for command
Date: Thu, 13 Mar 2008 12:47:58 +0100
Message-ID: <80b317760803130447u6d1998ecv3fcbc018a37a7247@mail.gmail.com>
References: <47D8F73F.4090501@gmail.com>
	 <9ea470500803130255u3dbed41bwd02c16ea79a09152@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:65046 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbYCMLsA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 07:48:00 -0400
Received: by wr-out-0506.google.com with SMTP id 50so2412995wra.13
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 04:47:58 -0700 (PDT)
In-Reply-To: <9ea470500803130255u3dbed41bwd02c16ea79a09152@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Have you tried a more recent kernel? Your bisection interval is .23 and .24-rc1,
>  and a lot of code went into ide after that. However, you should try to
>  avoid 2.6.24
>  since ide-cd was broken there. I'd go with 2.6.25-rc5, for example.

I did not tried it personnaly, but at least 2 persons on the ubuntu
bug tracker did.
The bug is still there.
