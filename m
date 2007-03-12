From: Tejun Heo <htejun@gmail.com>
Subject: Re: Adaptec 1220SA (Sil3132) & sata_sil24 question
Date: Tue, 13 Mar 2007 02:26:39 +0900
Message-ID: <45F58D4F.5030408@gmail.com>
References: <45E65540.6090308@metaparadigm.com> <45F533F8.3050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:34630 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbXCLR0j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 13:26:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1741590wxd
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 10:26:38 -0700 (PDT)
In-Reply-To: <45F533F8.3050401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Clark <jclark@metaparadigm.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> James Clark wrote:
>> I have an Adaptec 1220SA which I originally thought was just a re-badged
>> Sil3132 design. Externally it appears that way (the stamp on the chip
>> reads 3132), however it identifies as a Silicon Image type 0x0242
>> according to lspci.  sata_sil24 does not attach.
>>
>> I made the trivial addition to sata_sil24 device id table and it appears
>> to work. Performance is about the same as I get with the same drives on
>> the onboard sata_via (about 78MB/s sequential read, 72MB/s write) and
>> md mirror resyncing reflects this.
> 
> I'll ask SIMG about it.

Okay, SIMG verified it.  Can you please post the patch with proper
subject, description and Signed-off-by?  The following is a good example.

  http://article.gmane.org/gmane.linux.ide/16956

Anything from --- to the start of the patch is optional (including ---
itself).

Thanks.

-- 
tejun
