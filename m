From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
Date: Thu, 19 Oct 2006 01:24:37 +0900
Message-ID: <45365545.9000703@gmail.com>
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>	 <451E7BD2.7020002@gmail.com>	 <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>	 <4529BCC4.8060906@gmail.com>	 <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>	 <4529F391.3030504@gmail.com> <20061009070652.GE10832@htj.dyndns.org> <4807377b0610171613i5df25ddekb8c470d767a11005@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.192]:45370 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751482AbWJRQYq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Oct 2006 12:24:46 -0400
Received: by nz-out-0102.google.com with SMTP id z3so118459nzf
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2006 09:24:46 -0700 (PDT)
In-Reply-To: <4807377b0610171613i5df25ddekb8c470d767a11005@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Joe Jin <lkmaillist@gmail.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Jesse Brandeburg wrote:
> Is this patch going to go upstream?  I've been testing 2.6.18 on a
> couple different systems and seen the same issue.  I haven't tested
> the patch yet.

The patch is pending review.

http://thread.gmane.org/gmane.linux.ide/13408/focus=13439

-- 
tejun
