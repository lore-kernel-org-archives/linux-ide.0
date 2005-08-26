From: Yani Ioannou <yani.ioannou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PATCH: ide: ide-disk freeze support for hdaps
Date: Fri, 26 Aug 2005 01:04:15 -0400
Message-ID: <253818670508252204b22e8c2@mail.gmail.com>
References: <253818670508250708a9075a0@mail.gmail.com>
	 <58cb370e0508250859701ea571@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <hdaps-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <58cb370e0508250859701ea571-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: hdaps-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: hdaps-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/hdaps-devel>,
	<mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:hdaps-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/hdaps-devel>,
	<mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=hdaps-devel>
To: Bartlomiej Zolnierkiewicz <bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jon Escombe <lists-Xbpc2PeERmvQXOPxS62xeg@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Jens Axboe <axboe-l3A5Bk7waGM@public.gmane.org>, Alejandro Bonilla Beeche <abonilla-N/cRWR3FREN3ZuITGxAgx9i2O/JbrIOy@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, hdaps devel <hdaps-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi Bartlomiej,

Thank you for your feedback :), as this is my first dabble in
ide/block drivers I certainly need it!

On 8/25/05, Bartlomiej Zolnierkiewicz <bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> +config IDEDISK_FREEZE
>=20
> Is there any advantage of having it as a config option?

The main reasons I added the config option:
- the freeze feature is really only useful to an (increasing) niche of
mobile computers with an accelerometer.

- it might actually be detrimental to most other systems, you would
never want to freeze the queue on most machines - especially a
production system, and for that reason alone it seemed sensible to me
to be able to selectively remove it completely.

- to re-inforce the experimental nature of the patch, and disable it
by default (although this could be achieved just with EXPERIMENTAL I
suppose).

> Please make the interface accept number of seconds (as suggested by Jens)
> and remove this module parameter. This way interface will be more flexibl=
e
> and cleaner.  I really don't see any advantage in doing "echo 1 > ..." in=
stead
> of "echo x > ..." (Pavel, please explain).

Either way is pretty easy enough to implement. Note though that I'd
expect the userspace app should thaw the device when danger is out of
the way (the timeout is mainly there to ensure that the queue isn't
frozen forever, and should probably be higher). Personally I don't
have too much of an opinion either way though... what's the consensus?
:).

I can understand Pavel's opinion in that a enable/disable attribute in
sysfs seems the norm, and is more intuitive. Also what should 'cat
/sys/block/hda/device/freeze' return for a 'echo x >
/sys/block/hda/device/freeze' sysfs attribute? The seconds remaining?
1/0 for frozen/thawed?

> +static void freeze_expire(unsigned long data);
> +static struct timer_list freeze_timer =3D
> +       TIMER_INITIALIZER(freeze_expire, 0, 0);
>=20
> There needs to be a timer per device not a global one
> (it works for a current special case of T42 but sooner
>  or later we will hit this problem).

I was considering that, but I am confused as to whether each drive has
it's own queue or not? (I really am a newbie to this stuff...). If so
then yes there should be a per-device timer.

> queue handling should be done through block layer helpers
> (as described in Jens' email) - we will need them for libata too.

Good point, I'll try to move as much as I can up to the block layer,
it helps when it comes to implementing freeze for libata as you point
out too.

> At this time attribute can still be in use (because refcounting is done
> on drive->gendev), you need to add "disk" class to ide-disk driver
> (drivers/scsi/st.c looks like a good example how to do it).

I missed that completely, I'll look at changing it.

> IMO this should also be handled by block layer
> which has all needed information, Jens?
>=20
> While at it: I think that sysfs support should be moved to block layer (q=
ueue
> attributes) and storage driver should only need to provide queue_freeze_f=
n
> and queue_thaw_fn functions (similarly to cache flush support).  This sho=
uld
> be done now not later because this stuff is exposed to the user-space.

I was actually considering using a queue attribute originally, but in
my indecision I decided to go with Jen's suggestion. A queue attribute
does make sense in that the attribute primarily is there to freeze the
queue, but it would also be performing the head park. Would a queue
attribute be confusing because of that?

>=20
> +               /*
>                  * Sanity: don't accept a request that isn't a PM request
>                  * if we are currently power managed. This is very import=
ant as
>                  * blk_stop_queue() doesn't prevent the elv_next_request(=
)
> @@ -1661,6 +1671,9 @@ int ide_do_drive_cmd (ide_drive_t *drive
>                 where =3D ELEVATOR_INSERT_FRONT;
>                 rq->flags |=3D REQ_PREEMPT;
>         }
> +       if (action =3D=3D ide_next)
> +               where =3D ELEVATOR_INSERT_FRONT;
> +
>         __elv_add_request(drive->queue, rq, where, 0);
>         ide_do_request(hwgroup, IDE_NO_IRQ);
>         spin_unlock_irqrestore(&ide_lock, flags);
>=20
> Why is this needed?

I think Jon discussed that in a previous thread, but basically
although ide_next is documented in the comment for ide_do_drive_cmd,
there isn't (as far as Jon or I could see) anything actually handling
it. This patch is carried over from Jon's work and adds the code to
handle ide_next by inserting the request at the front of the queue.

> Overall, very promising work!

Thanks :-), most of it is Jon's work, and Jen's suggestions though.

Yani

P.S. Sorry about the lack of [] around PATCH...lack of sleep. Its more
of a RFC anyway.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
