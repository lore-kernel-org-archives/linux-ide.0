From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: segate drives are not getting detected in SIL3114 and promise
 card
Date: Wed, 11 Mar 2009 22:32:41 -0600
Message-ID: <49B89069.9040001@gmail.com>
References: <3fb94e50903112046t24a480a6lcd49a771c706f555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:51974 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbZCLEcq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2009 00:32:46 -0400
Received: by qw-out-2122.google.com with SMTP id 5so327297qwi.37
        for <linux-ide@vger.kernel.org>; Wed, 11 Mar 2009 21:32:44 -0700 (PDT)
In-Reply-To: <3fb94e50903112046t24a480a6lcd49a771c706f555@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Sagar Borikar wrote:
> Hi,
> 
> We have found that some 1TB (ST31000340AS model) and 750GB hard drives
> are not getting detected after reboot of NAS system.
> If I remove and insert it again, sometimes it get detected. Overall,
> its stochastic behaviour of the detection. This happens only in case
> of seagate drives and that too with 1TB and 750GB.
> 

(snip)

> 
> 
> Same issue is seen on silicon image 3114 with 4 drive controller.But
> surprisingly  this is not observed on 3512, 2 bay controller.
> We are using 2.6.18 kernel and on MIPS architecture.
> 
> Any pointers?

2.6.18 is pretty ancient at this point, can you try a newer kernel?
