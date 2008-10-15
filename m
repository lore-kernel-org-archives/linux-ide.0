From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil for 3512A chip on kernel 2.6.26.3
Date: Wed, 15 Oct 2008 16:25:29 +0900
Message-ID: <48F59AE9.7050203@kernel.org>
References: <48E48BF2.1010403@gmail.com> <48E71DBC.5090301@kernel.org> <48F47924.9040504@gmail.com> <48F54E4C.1020704@kernel.org> <48F58FBE.909@gmail.com> <48F591CC.6090609@kernel.org> <48F595CA.5000807@gmail.com> <48F5965A.5000709@kernel.org> <48F5998E.4090205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49557 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbYJOH1O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 03:27:14 -0400
In-Reply-To: <48F5998E.4090205@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damazy <damazy@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Damazy wrote:
> Tejun Heo wrote:
>>
>> I'm afraid there's nothing much can be done from the driver here.  Looks
>> like your drive's PHY is just bonkers or it just doesn't like talking to
>> the controller.  Can you try the drive on a different controller?
>>
>> Thanks.
>>
> 
> As I wrote before, it was tested on different platform with different os
> and it workek just fine.

Ah.. so, different drive works fine on the same configuration and the
same drive works fine on different configuration.  I don't have much
idea how to fix it.  It looks like a bad combination of hardware to me.
 Maybe the add-on card is wiring cables slightly out of spec and the
receiving PHY of the drive is a bit too sensitive about it (note that
the controller is not reporting any PHY events but the drive is
reporting ICRC).

-- 
tejun
