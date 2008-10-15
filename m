From: Damazy <damazy@gmail.com>
Subject: Re: sata_sil for 3512A chip on kernel 2.6.26.3
Date: Wed, 15 Oct 2008 09:19:42 +0200
Message-ID: <48F5998E.4090205@gmail.com>
References: <48E48BF2.1010403@gmail.com> <48E71DBC.5090301@kernel.org> <48F47924.9040504@gmail.com> <48F54E4C.1020704@kernel.org> <48F58FBE.909@gmail.com> <48F591CC.6090609@kernel.org> <48F595CA.5000807@gmail.com> <48F5965A.5000709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:53716 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYJOHT2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 03:19:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2535852fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 00:19:26 -0700 (PDT)
In-Reply-To: <48F5965A.5000709@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 
> I'm afraid there's nothing much can be done from the driver here.  Looks
> like your drive's PHY is just bonkers or it just doesn't like talking to
> the controller.  Can you try the drive on a different controller?
> 
> Thanks.
> 

As I wrote before, it was tested on different platform with different os 
and it workek just fine.

TIA

-- 
Damazy
