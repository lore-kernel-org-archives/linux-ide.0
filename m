From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem with SiI 3112 SATA Controller/Driver ?
Date: Thu, 13 Jul 2006 01:12:39 +0900
Message-ID: <44B51F77.5080607@gmail.com>
References: <44B41C25.6030209@paranor.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:57644 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751447AbWGLQLj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Jul 2006 12:11:39 -0400
Received: by nz-out-0102.google.com with SMTP id l1so161474nzf
        for <linux-ide@vger.kernel.org>; Wed, 12 Jul 2006 09:11:38 -0700 (PDT)
In-Reply-To: <44B41C25.6030209@paranor.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@paranor.org.uk
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Ellis wrote:
> Jeff
> 
> I'm afraid that I'm going to bother you with my woes ...
> 
> I have a SATA controller that is giving me problems and I'm looking for 
> some advice. I am including quite a bit of information in the hope that 
> it will help.

Can you try the following patch?

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710.tar.bz2

-- 
tejun
