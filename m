From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Tue, 21 Nov 2006 15:58:32 +0900
Message-ID: <4562A398.5070901@gmail.com>
References: <1163523e0611091429x4725fbc8p563201285d8b1371@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:62448 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S934195AbWKUG6l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 01:58:41 -0500
Received: by nf-out-0910.google.com with SMTP id o25so83733nfa
        for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2006 22:58:40 -0800 (PST)
In-Reply-To: <1163523e0611091429x4725fbc8p563201285d8b1371@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Cohen <jcohen@llnl.gov>
Cc: linux-ide@vger.kernel.org, hancockr@shaw.ca

Jonathan Cohen wrote:
> I'm not sure if this will make it to the list or be filtered out (I'm
> not a list member), but I am having what looks like a very similar
> problem to Mark Hatle with NVRAID on 2.6.18 (fc6). My machine is
> working for a number of hours and then has some kind of disk problem
> (so far, it has been mostly when I leave in the evening). My log file
> is below. Please cc any responses to me at jcohen@llnl.gov. Thanks!

Robert Hancock just added a lot of new features including new error 
handling to sata_nv.  Please give 2.6.19-rc5-mm2 a shot.

Thanks.

-- 
tejun
