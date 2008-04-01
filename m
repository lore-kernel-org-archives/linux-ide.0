From: Tejun Heo <htejun@gmail.com>
Subject: Re: Need help understanding SATA error message.
Date: Tue, 01 Apr 2008 09:26:15 +0900
Message-ID: <47F18127.8070509@gmail.com>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca> <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se> <47EDBC87.8090109@rtr.ca> <Pine.LNX.4.61.0803301659300.5510@envy.nxs.se> <47F0376F.2090000@gmail.com> <47F0FAD3.9060001@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:33135 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbYDAA0V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2008 20:26:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1053635rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 31 Mar 2008 17:26:21 -0700 (PDT)
In-Reply-To: <47F0FAD3.9060001@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tomas Lund <tlund@nxs.se>, linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

Mark Lord wrote:
>> The response to an unrecoverable sector shouldn't be 51/04 if the
>> flush fails, it should be 51/10 or 51/40.
>>
>> 51/04 would be the response if the FLUSH CACHE command was issued when
>> there were still outstanding NCQ commands active.
> ..
> 
> Tejun:  I see we have another thread as well with FLUSH errors.
> I really doubt that these are bad drives.
> There's very likely a bug in libata / LLD there someplace.

Possibly.  The only thing I can think of which can screw FLUSH is 
issuing it when NCQ phase is still in progress as was in the case for 
ADMA.  FLUSH being a non-data command, it's pretty difficult to get it 
wrong otherwise.  The thing is that sata_sil24 does its own command 
sequencing and even if libata slips there a bit, the silicon won't issue 
FLUSH if NCQ is in progress, so I'm a bit skeptical.  Any other ideas?

-- 
tejun
