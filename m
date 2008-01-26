From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata error codes
Date: Sat, 26 Jan 2008 10:54:19 +0900
Message-ID: <479A92CB.7070504@gmail.com>
References: <5d96567b0801150939y3802a73aqcbab553af5fe6015@mail.gmail.com>	 <47945202.8090107@gmail.com> <5d96567b0801250313x4f5d0b62q6147ec5d873bb002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:55329 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbYAZBy0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 20:54:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so926392rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2008 17:54:25 -0800 (PST)
In-Reply-To: <5d96567b0801250313x4f5d0b62q6147ec5d873bb002@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raz <raziebe@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Raz wrote:
> I saw in Jeff Garzik the link to http://www.t13.org/ for the ata 's
> documentation. Unfortunately , I do seem to be able to correlate the
> errors in the specs to the errors appear in dmesg. If you would be
> kind to direct me a little, I would write a code that dumps more
> information, something like ata_error err = <error code > utility.

What do you mean by 'utility'?  A separate program to interpret kernel
error message?

-- 
tejun
