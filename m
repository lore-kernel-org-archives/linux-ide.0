From: Guillermo Amaral <g@maral.me>
Subject: Re: [PATCH] Add factory recertified Crucial M500s to blacklist
Date: Wed, 26 Aug 2015 10:40:25 -0700
Message-ID: <CAPeEpDprdG0P6qwMY1CeyN6BWLmxK5+oQ5qpKqOb7XSSaWDyTA@mail.gmail.com>
References: <1440570553-1600-1-git-send-email-g@maral.me>
	<1440570553-1600-2-git-send-email-g@maral.me>
	<yq1si762hu8.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36369 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448AbbHZRk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2015 13:40:26 -0400
Received: by qgeb6 with SMTP id b6so130829500qge.3
        for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2015 10:40:26 -0700 (PDT)
In-Reply-To: <yq1si762hu8.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Wed, Aug 26, 2015 at 8:24 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Guillermo" == Guillermo A Amaral <g@maral.me> writes:
>
> Guillermo> The Crucial M500 is known to have issues with queued TRIM
> Guillermo> commands, the factory recertified SSDs use a different model
> Guillermo> number naming convention which causes them to get ignored by
> Guillermo> the blacklist.
>
> No particular objection to the patch. But I have asked Micron for
> details since this may affect more of the blacklist entries.

Good idea. I was waiting for a referb M550 that's in the mail to
confirm if it also has a similar naming convention, but your approach
seems much more direct. :)

-- 
gamaral
http://about.me/gamaral
