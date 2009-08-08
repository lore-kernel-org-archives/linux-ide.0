From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sat, 08 Aug 2009 14:59:33 -0600
Message-ID: <4A7DE735.6090409@gmail.com>
References: <h5kn9c$51r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:14553 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZHHU7h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Aug 2009 16:59:37 -0400
Received: by an-out-0708.google.com with SMTP id d40so2283458and.1
        for <linux-ide@vger.kernel.org>; Sat, 08 Aug 2009 13:59:37 -0700 (PDT)
In-Reply-To: <h5kn9c$51r$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Duda <jim@duda.tzo.com>
Cc: linux-ide@vger.kernel.org

On 08/08/2009 02:30 PM, Jim Duda wrote:
> Hello,
>
> I'm having trouble using my STT2000A ATAPE TAPE drive after upgrading to
> at least kernel 2.6.30. I use the tape drive solely for tape backup
> using simple tar commands.
>
> In previous kernels, I was able to access the tape drive using the
> ide-scsi adaptation layer with /dev/st0
>
> I realize that in transitioning through 2.6.30 the kernel has abandoned
> the use of ide-scsi. As I understand it, ide-tape interacts directly
> with the tape drive and I am supposed to now use /dev/ht0.

My first suggestion would be to try using the libata drivers instead of 
the old IDE ones. The st driver should be able to access the tape then. 
I'm not sure if many people are running ATAPI tape drives on libata 
these days, but the old IDE drivers certainly don't get a lot of use.
