From: Shaun Tancheff <shaun@tancheff.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Wed, 24 Aug 2016 17:04:05 -0500
Message-ID: <CAJ48U8XgkjapcfZTka0xFKa3h=tEEE5hW3d9tuL4Q1MW88NEFw@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSEmVbkJ30uNbW1O-Wh4E7RKbf+OojxRYjWanMYH_OrvHnA@mail.gmail.com>
 <CAJVOszDck0HOVKdnqG=wWyE9G=gGwmouh-YF2RL93AJHvbSTcg@mail.gmail.com>
 <CAGnHSEmQz9tLrUjE4UF_Taa6tUjO1X22o5GcU79KFPXHaOTGOg@mail.gmail.com> <CAGnHSEnEUu0E3rQmyB3+wjUK8v-Ojg8xpKxMMZoiXHdfWwuhkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38389 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754060AbcHXWEH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Aug 2016 18:04:07 -0400
In-Reply-To: <CAGnHSEnEUu0E3rQmyB3+wjUK8v-Ojg8xpKxMMZoiXHdfWwuhkg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On Wed, Aug 24, 2016 at 1:10 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> Btw, I wonder if you need to memset your buffer with 0 first, like
> what is done in ata_scsi_rbuf_get.

It is not necessary as the defined buffer is completely filled out here.

Are you thinking as a sort of future proofing?
Ex: In the unlikely event that the SCT Write Same command
descriptor is expanded in a future ACS?

It is more likely to see the command deprecated and replaced with a
new SCT feature.

Regardless of how unlikely I would consider a memset here to clear
the remainder of the payload.
