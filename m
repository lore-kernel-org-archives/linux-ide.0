From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Mon, 25 Oct 2004 15:18:47 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <417D5197.5030405@tmr.com>
References: <m3zn2boq1h.fsf@lugabout.cloos.reno.nv.us><58cb370e04102405081d62bf40@mail.gmail.com> <58cb370e04102413156543b72e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:39313 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261263AbUJYTQc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Oct 2004 15:16:32 -0400
In-Reply-To: <58cb370e04102413156543b72e@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: James Cloos <cloos@jhcloos.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sun, 24 Oct 2004 12:48:58 -0700, James Cloos <cloos@jhcloos.com> wrote:
> 
>>Are all of the data displayed in /proc/ide/piix et al now available
>>in sysfs?  If so, 'twould've been useful for a small utility -- a
> 
> 
> All these data can be obtained from user-space,
> no need for bloating sysfs.
> 
> 
>>la lsscsi(8) -- that can format that data like the /proc/ide files
>>to have been released before dropping the /proc files....
>>It is a regression to loose convenient access to the controllers'
>>current configs....
> 
> 
> http://home.elka.pw.edu.pl/~bzolnier/atapci/
> 
> released > 2 years ago :)
> 
> works fine but probably needs some cut'n'paste updates

Other than one obvious patch to get rid of all the warnings from putting 
comments after #endif w/o a comment inducer, seems to work...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
