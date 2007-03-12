From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata Intel PIIX/ICH fails to detect both PATA drives, spews
 ACPI errors
Date: Mon, 12 Mar 2007 16:09:23 +0900
Message-ID: <45F4FCA3.1080301@gmail.com>
References: <45705618.2020608@gmail.com> <45E447DD.9050308@gmail.com> <45F3F8AA.4060501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:40563 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965254AbXCLHJ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 03:09:26 -0400
Received: by py-out-1112.google.com with SMTP id a29so476655pyi
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 00:09:26 -0700 (PDT)
In-Reply-To: <45F3F8AA.4060501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Berck.

Berck E. Nash wrote:
> Tejun Heo wrote:
>> Berck E. Nash wrote:
>>> Testing the new libata ICH PATA drivers.  There's one PATA port on this
>>> chip, and I've got two optical drives connected to it.  The master drive
>>> fails to detect.  The slave detects and works properly.
>> Can you test 2.6.20.1 and post full dmesg?
> 
> Here's 2.6.20.2...  No ACPI errors, but still doesn't detect both drives.

Please apply the attached patch and see if it works.  If it works,
please post the result of hdparm -I /dev/srX of the optical drive.  Thanks.

-- 
tejun
