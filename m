From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
Date: Sun, 8 Jul 2007 15:31:43 +0200
Message-ID: <3F401C47-2A18-4692-AA71-D0D5FE24D94F@kernel.crashing.org>
References: <20070707094852.9473.21013.stgit@localhost.localdomain> <20070707094900.9473.48577.stgit@localhost.localdomain> <468FC376.2040405@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51805 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbXGHNcE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Jul 2007 09:32:04 -0400
In-Reply-To: <468FC376.2040405@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

>> +		ide@10000000 {
>> + 			#interrupt-cells = <2>;
>
>     Hm, why define that prop for a node with no children?
>
>> + 			interrupts = <17 8>;
>> + 			interrupt-map = <0 0 0 1 700 17 8>;
>> + 			interrupt-map-mask = <0>;

This map-mask makes no sense either.  And neither does
the map itself.

>> +
>> + 			#size-cells = <1>;
>> + 			#address-cells = <1>;
>
>     Same question here.

The ide node might want children, namely disks or optical
drives or such, but #size-cells should be 0.

>> + 			reg = <10000000 10 10000200 10>;
>> +
>> + 			device_type = "ide";
>
>     I think that already adopted device type is "ata", not "ide".

"ata" is not a hardware thing, "ide" is.  Or so I'm told.
I'd leave out the "device_type" completely though, certainly
if you can't point me at a published device binding :-)


Segher
