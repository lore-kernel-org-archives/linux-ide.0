From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
Date: Mon, 09 Oct 2006 12:06:44 +0900
Message-ID: <4529BCC4.8060906@gmail.com>
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>	 <451E7BD2.7020002@gmail.com> <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:31238 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932204AbWJIDGy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Oct 2006 23:06:54 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1828053nfb
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 20:06:53 -0700 (PDT)
In-Reply-To: <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Jin <lkmaillist@gmail.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Joe Jin wrote:
> it still  occured after apply the patch :(

SRST failure would have still occurred but 30sec timeout should have 
gone.  Can you post full dmesg?

Also, please test the patch in the following mail.  You can use either 
git or download the full kernel tarball to get the modified kernel.

http://article.gmane.org/gmane.linux.ide/13284

Thanks.

-- 
tejun
