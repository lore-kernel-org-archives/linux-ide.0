From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 02/24] workqueue: defer work to a draining queue
Date: Mon, 19 Dec 2011 14:01:47 -0800
Message-ID: <CAA9_cmffHn0tqjF55ZAYi_xG=JakwK28QP=Vj=irP9MwoqWBSw@mail.gmail.com>
References: <20111217022912.15036.85808.stgit@localhost6.localdomain6>
	<20111217023318.15036.77389.stgit@localhost6.localdomain6>
	<20111219214924.GA6256@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61568 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab1LSWBs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2011 17:01:48 -0500
In-Reply-To: <20111219214924.GA6256@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Dec 19, 2011 at 1:49 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Fri, Dec 16, 2011 at 06:33:18PM -0800, Dan Williams wrote:
>> commit 9c5a2ba7 "workqueue: separate out drain_workqueue() from
>> destroy_workqueue()" provided drain_workqueue() for users like libsa=
s to
>> use for flushing events.
>>
>> When libsas drains it wants currently queued and chained events to b=
e
>> flushed, but it fully expects to continue issuing unchained events w=
ith
>> the expectation that they are serviced sometime after the drain.
>>
>> For external users of drain_workqueue() arrange for unchained work t=
o be
>> queued after the drain completes, if the caller cares if unchained w=
ork
>> was queued as a result of the drain it can check for a non-zero retu=
rn
>> value. =A0Deferred work is guaranteed to be at least queued when
>> drain_workqueue() returns, and visible to flush_workqueue() users as
>> well.
>>
>> Unfortunately this causes the promotion of workqueue_lock to hard-ir=
q
>> safe and does not guarantee that work submitted via queue_work_on() =
runs
>> on the specified cpu if it gets deferred.
>>
>> Cc: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Dan, as I replied before, I'm not a big fan of this approach.

Sorry I must have missed it, I can't seem to find a reply in the archiv=
es?

> For
> now, I think it would be best to add private wrapper in libsas to
> support deferring unchained work items while draining.

Ok, a form of this was nak'd by James before [1], but I can try again
with pushing this chained submission checking down into scsi.

--
Dan

[1]: http://marc.info/?l=3Dlinux-scsi&m=3D130655248916967&w=3D2
