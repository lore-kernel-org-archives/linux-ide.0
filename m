From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA timeout value
Date: Tue, 24 Apr 2007 00:50:00 +0900
Message-ID: <462CD5A8.4000004@gmail.com>
References: <14380803.14661177341114878.JavaMail.servlet@perfora>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:31656 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbXDWPvC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 11:51:02 -0400
Received: by nz-out-0506.google.com with SMTP id o1so127108nzf
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 08:50:57 -0700 (PDT)
In-Reply-To: <14380803.14661177341114878.JavaMail.servlet@perfora>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell Sloan <russell.sloan@lingua-data.com>
Cc: linux-ide@vger.kernel.org

Russell Sloan wrote:
> I'm using SG_IO and I'm curently passing in:
>   sg_io_hdr_t.timeout = 5;
> 
> This should be a 5 ms timeout, correct?  I've tried a few different values, from 5 to 1000 and it still takes 90+ seconds for it to timeout and return to my program.
> 
> I will try HDIO and see if that behaves any differently.

It might be retrying.  Can you post dmesg after the command?

-- 
tejun
