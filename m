From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: 2.6.22.6 sata_sil device errors & timeouts
Date: Thu, 27 Sep 2007 22:59:11 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0709272257330.4057@trinity.phys.uwm.edu>
References: <76366b180709170135v6c46f3d6qd3586ea79f9abc2@mail.gmail.com>
 <46EE4679.7030600@gmail.com>  <76366b180709170904i7b2f5ab0o8605eb899d20f921@mail.gmail.com>
  <46EEB449.8010305@gmail.com>  <76366b180709171205v5783fb9ave52b7e999da96f07@mail.gmail.com>
  <76366b180709171226j5a299502q1a13f158d9b704aa@mail.gmail.com>
 <Pine.LNX.4.63.0709171433120.28104@trinity.phys.uwm.edu>
 <76366b180709171406g61f09f39la8deeb3201ad0e37@mail.gmail.com>
 <Pine.LNX.4.63.0709180028270.28104@trinity.phys.uwm.edu>
 <76366b180709180736h57f956ccld8fba04070f02408@mail.gmail.com>
 <Pine.LNX.4.63.0709181032270.17786@trinity.phys.uwm.edu> <46FB58A0.3040109@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.phys.uwm.edu ([129.89.57.159]:39023 "EHLO
	trinity.phys.uwm.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbXI1D70 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 23:59:26 -0400
In-Reply-To: <46FB58A0.3040109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Paprocki <andrew.m.paprocki@gmail.com>, Bruce Allen <bruce.allen@aei.mpg.de>, linux-ide@vger.kernel.org

Hi Tejun,

Thanks! Yes I meant HDIO_DRIVE_TASK.  Please let me know what your tests 
reveal.

Cheers,
 	Bruce


On Thu, 27 Sep 2007, Tejun Heo wrote:

> Bruce Allen wrote:
>> Andrew: thanks for isolating this problem.
>>
>> Tejun: any thoughts?  The STRANGE_BUFFER_LENGTH problem is fixed in the
>> code that Andrew is running.  The problem is provoked with '-o on' which
>> goes via a TASKFILE ioctl.
>
> I suppose you mean HDIO_DRIVE_TASK, right?  libata doesn't implement
> HDIO_DRIVE_TASKFILE and it probably never will.  I'll test it next week
> when I get back.  Thanks.
>
>
