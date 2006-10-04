From: girish <girishvg@gmail.com>
Subject: Re: PCI/IDE generic IDE driver + bus master DMA logic errors
Date: Wed, 4 Oct 2006 20:06:11 +0900
Message-ID: <F31D7E0B-1FCD-4A86-8160-4025B13CFE0E@gmail.com>
References: <28EE04D1-1645-4D2C-9D8B-FB4877779223@gmail.com> <1159960645.25772.7.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:55626 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030822AbWJDLGS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Oct 2006 07:06:18 -0400
Received: by py-out-1112.google.com with SMTP id n25so230642pyg
        for <linux-ide@vger.kernel.org>; Wed, 04 Oct 2006 04:06:18 -0700 (PDT)
In-Reply-To: <1159960645.25772.7.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Oct 4, 2006, at 8:17 PM, Alan Cox wrote:

> Ar Mer, 2006-10-04 am 19:07 +0900, ysgrifennodd girish:
>> our hardware guys are designing an pci/ide controller which has
>> interrupt wrapper such that the ide & bus master interrupts are
>> packaged & delivered together.
>
> All the SFF8038i/D1510 style devices have a single interrupt line for
> IDE and for bus mastering interrupts. If your device behaves in
> accordance to D1510 the default code ought to work.
>
> Alan

thanks alan. i will have look into it.

one more question - we are planning two channel bus-mastering design.  
whether linux ide sub-system will support simultaneous dma kick  
sequences?



