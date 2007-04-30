From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata sil driver...
Date: Mon, 30 Apr 2007 11:04:31 +0200
Message-ID: <4635B11F.7050106@gmail.com>
References: <3062.192.168.25.101.1177726210.squirrel@mail.tortpro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:22390 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbXD3TuG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 15:50:06 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1694468wra
        for <linux-ide@vger.kernel.org>; Mon, 30 Apr 2007 12:50:05 -0700 (PDT)
In-Reply-To: <3062.192.168.25.101.1177726210.squirrel@mail.tortpro.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: geoff@abu.mn.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Geoff Kuchera wrote:
> Symptoms:  The system finds all the drives and everything appears to work
> correctly, but when I partition and make a file system on the drive and
> then copy files to the drive some of the files become corrupted in the
> transfer process.

What do you mean by 'the files become coruppted'?  md5sum becomes
different?  If so, what does 'cmp -l original_file copied_file' tells
you?  Have you verified your ram is okay (memtest86)?  Please also post
boot dmesg.

-- 
tejun

