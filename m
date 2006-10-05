From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] [PATCH] ahci: honor PORTS_IMPL on ICH8s
Date: Fri, 06 Oct 2006 00:12:34 +0900
Message-ID: <452520E2.9000802@gmail.com>
References: <20060930122121.GR25800@htj.dyndns.org> <20060930122259.GS25800@htj.dyndns.org> <4524EB91.1020303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:19599 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751497AbWJEPM2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Oct 2006 11:12:28 -0400
Received: by ug-out-1314.google.com with SMTP id o38so201978ugd
        for <linux-ide@vger.kernel.org>; Thu, 05 Oct 2006 08:12:27 -0700 (PDT)
In-Reply-To: <4524EB91.1020303@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, robbat2@gentoo.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Some ICH8s use non-linear port mapping.  ahci driver didn't use to
>> honor PORTS_IMPL and this made ports after hole nonfunctional.  This
>> patch implements port mapping table and use it to handle non-linear
>> port mapping.
>>
>> As it's unknown whether other AHCIs implement PORTS_IMPL register
>> properly, new board id board_ahci_pi is added and selectively applied
>> to ICH8s.  All other AHCIs continue to use linear mapping regardless
>> of PORTS_IMPL value.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: Robin H. Johnson <robbat2@gentoo.org>
> 
> I still disagree with the port mapping table.  I want to preserve the 
> direct index properties, and would rather see code fixed up such that 
> assumptions where n_ports implies all lower ports are fixed.

I understand your concern but if you think about it, if you have 
non-linear port mapping and wanna keep direct index property, 
something's gotta give.  There are three places to deal with the 
mismatch - in LLD, libata or userland.

* LLD: this is what the current patch does and my favorite.  It's 
isolated, not too complex and easy to spot when something goes wrong.

* libata: we can implement non-linear mapping facility in core layer but 
I'm doubtful it's worth the effort and complexity.  Not many LLDs use 
non-linear mapping and ones that do are likely to have peculiar properties.

* userland: this is how we currently handle busy legacy ports.  Mark 
them dummy and let the userland see that some ports aren't implemented. 
  This makes sense for legacy ports because they have fixed resources 
and port numbers are bound to those resources.  However, for ahci's 
case, I think it will cause confusion as the port numbers don't have any 
specific meaning and the BIOS and other OSes show them as contiguous ports.

So, my place of choice is in LLD.  What do you think?

Thanks.

-- 
tejun
