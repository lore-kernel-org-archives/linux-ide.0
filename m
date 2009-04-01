From: James Andrewartha <jamesa@daa.com.au>
Subject: Re: Mysteriously slow writes SiI 3124
Date: Wed, 01 Apr 2009 13:34:00 +0800
Message-ID: <49D2FCC8.1060204@daa.com.au>
References: <49AB079A.9090407@rabbit.us> <49AE294D.2020002@rabbit.us> <da824cf30903040910gff4d99en8fc8097fc6a05668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from quoll.daa.com.au ([203.17.251.1]:40214 "EHLO quoll.daa.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbZDAFmL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 01:42:11 -0400
In-Reply-To: <da824cf30903040910gff4d99en8fc8097fc6a05668@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Peter Rabbitson <rabbit+list@rabbit.us>, linux-ide@vger.kernel.org

Grant Grundler wrote:
> On Tue, Mar 3, 2009 at 11:10 PM, Peter Rabbitson <rabbit+list@rabbit.us> wrote:
>> No takers? Can I provide more info/measurements/whatever? I would
>> really like to get to the bottom of this, pretty frustrating.
> 
> Are you ok with wild guesses?
> This sounds remarkable similar to the performance of the equivalent
> PCIe SATA controller from Silicon Image (3132). The 3132 has 1 PCI-E
> lane and should able to move more than 220 MB/s or so. But in fact can
> only read 120MB/s and write 170MB/s.

The hardware is limited:
http://ata.wiki.kernel.org/index.php/Hardware,_driver_status#Silicon_Image_3124
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg10143.html
http://markmail.org/message/dkwn2imwkjg7aeyl

-- 
James Andrewartha
