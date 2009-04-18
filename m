From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Frequent Head Unload Problem
Date: Fri, 17 Apr 2009 19:24:47 -0600
Message-ID: <49E92BDF.7060507@gmail.com>
References: <49E4BF3E.9040105@gavsworld.net> <49E537F4.8000807@gmail.com> <49E666B2.6090708@gavsworld.net> <49E67576.8070704@gmail.com> <49E8C14D.7020907@gavsworld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:36516 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbZDRBYw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 21:24:52 -0400
Received: by yw-out-2324.google.com with SMTP id 5so806703ywb.1
        for <linux-ide@vger.kernel.org>; Fri, 17 Apr 2009 18:24:51 -0700 (PDT)
In-Reply-To: <49E8C14D.7020907@gavsworld.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gavin Cameron <gavin@gavsworld.net>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Gavin Cameron wrote:
>> Can you try doing smartctl -a on both drives before and after you hear 
>> the noise and see if it seems to match up with any of the counters 
>> changing?
> 
> Here's the build up:
> sudo smartctl -a /dev/sda > sda_start
> sudo smartctl -a /dev/sdb > sdb_start
> ... a few mins while noises go on ...
> sudo smartctl -a /dev/sda > sda_end
> sudo smartctl -a /dev/sdb > sdb_end
> 
> Here are the results:
> diff sda_start sda_end
> 13c13
> < Local Time is:    Fri Apr 17 16:03:40 2009 BST
> ---
>  > Local Time is:    Fri Apr 17 16:17:20 2009 BST
> 66c66
> < 194 Temperature_Celsius     0x0002   253   253   000    Old_age 
> Always       -       17 (Lifetime Min/Max 9/38)
> ---
>  > 194 Temperature_Celsius     0x0002   240   240   000    Old_age 
> Always       -       25 (Lifetime Min/Max 9/38)
> 88a89
>  >
> 
> So nothing there apart from the temperature. However:
> diff sdb_start sdb_end
> 13c13
> < Local Time is:    Fri Apr 17 16:03:42 2009 BST
> ---
>  > Local Time is:    Fri Apr 17 16:17:26 2009 BST
> 57,59c57,59
> <   7 Seek_Error_Rate         0x000a   199   199   000    Old_age 
> Always       -       80
> <   8 Seek_Time_Performance   0x0027   246   238   187    Pre-fail 
> Always       -       39281
> <   9 Power_On_Minutes        0x0032   229   229   000    Old_age 
> Always       -       710h+53m
> ---
>  >   7 Seek_Error_Rate         0x000a   199   198   000    Old_age 
> Always       -       43
>  >   8 Seek_Time_Performance   0x0027   246   238   187    Pre-fail 
> Always       -       45449
>  >   9 Power_On_Minutes        0x0032   229   229   000    Old_age 
> Always       -       711h+07m
> 65,66c65,66
> < 194 Temperature_Celsius     0x0032   037   253   000    Old_age 
> Always       -       17
> < 195 Hardware_ECC_Recovered  0x000a   253   251   000    Old_age 
> Always       -       36907
> ---
>  > 194 Temperature_Celsius     0x0032   037   253   000    Old_age 
> Always       -       24
>  > 195 Hardware_ECC_Recovered  0x000a   253   251   000    Old_age 
> Always       -       31779
> 70c70
> < 199 UDMA_CRC_Error_Count    0x0008   084   001   000    Old_age 
> Offline      -       768
> ---
>  > 199 UDMA_CRC_Error_Count    0x0008   100   001   000    Old_age 
> Offline      -       768
> 72c72
> < 201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age 
> Always       -       0
> ---
>  > 201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age 
> Always       -       2
> 100a101
>  >
> 
> Looks to me like this drive could well be on its way out! None of the 
> counters (Start_Stop_Count for example) were changing, but lots of CRC 
> and error counts are.
> 
> What do you think? Just a knackered drive and nothing to do with libata 
> at all?

Yeah, it's possible that what you're hearing isn't a head unload at all, 
but some kind of abnormal recalibration noise, etc.

