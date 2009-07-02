From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Question about LS120 floppies
Date: Wed, 01 Jul 2009 23:22:35 -0600
Message-ID: <4A4C441B.6050808@gmail.com>
References: <4A4BC762.3090104@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:35406 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbZGBFV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jul 2009 01:21:28 -0400
Received: by yxe26 with SMTP id 26so2036225yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2009 22:21:31 -0700 (PDT)
In-Reply-To: <4A4BC762.3090104@lwfinger.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-ide@vger.kernel.org

On 07/01/2009 02:30 PM, Larry Finger wrote:
> I have been trying to help someone on the openSUSE forums. He is
> running a 2.6.27 kernel and finds that his "Super Floppy" drive works
> just fine for standard floppies, but will not accept one of the 120 MB
> disks. From what I read, the ide-atapi-floppy driver should be the
> correct one.
>
> Does the driver still support these disks?

Are they using the old IDE drivers, or libata? Do they have any kernel 
output, etc?
