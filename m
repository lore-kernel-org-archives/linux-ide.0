From: Pallav Bose <pallavbose@gmail.com>
Subject: Tweaking SCSI via sysfs
Date: Sat, 25 Jun 2011 23:47:58 -0400
Message-ID: <BANLkTimpY6ZozTs=XF6_NEL8x-Gi8g1eCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63026 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab1FZDsS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Jun 2011 23:48:18 -0400
Received: by iyb12 with SMTP id 12so3293383iyb.19
        for <linux-ide@vger.kernel.org>; Sat, 25 Jun 2011 20:48:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com, jaxboe@fusionio.com
Cc: Ganesh Karuppur Rajagopalan <ganesh.kr356@gmail.com>

Hello,

I'm working on 2.6.39.1 version of the linux kernel and am trying to
achieve a balance between high throughput and low latency for my
application. I have a block device driver which composes a struct bio
and calls the generic __make_request() function to create a struct
request and then add it to the request_queue. The scsi_request_fn() of
the device driver is finally used for servicing the request_queue.

I'm creating 1,000 requests, each of size 32KB, with destination
sectors as -- 0, 256, 512, 768, and so on. There is an artificial
inter-request delay (in blktrace terminology, this corresponds to Q2Q)
of 1 millisec being introduced by my driver between issuing each
request.

Various values for nr_requests was used -- 2, 4, 6, 8, 10, 20, and
finally 128. Also, nomerges (/sys/block/sda/queue/nomerges) was set to
2 to disable any sort of merging. And, of course, the write cache was
disabled.

Using blktrace, I tried to determine how much overhead is introduced
at different stages of issuing a write request to the disk. Here is
what I got:

1) Queue size is 2

The average per-request latency, throughput, and the percentage of
time spent in each of the phases of an IO are as follows:

  Q2G     |     G2I     |    I2D       |     D2C
----------------------------------------------------------------
6.2621%   0.0326%   0.0262%      93.6791%

[ 1535.426459] Average latency - 2471 microsecs per record
[ 1535.426462] Throughput = 856 records/sec


2) Queue size is 4

The average per-request latency, throughput, and the percentage of
time spent in each of the phases of an IO are as follows:

  Q2G     |     G2I     |    I2D       |     D2C
----------------------------------------------------------------
3.5292%   0.0171%    23.8169%  72.6368%

[ 2284.997171] Average latency - 4884 microsecs per record
[ 2284.997175] Throughput = 842 records/sec


3) Queue size is 6

The average per-request latency, throughput, and the percentage of
time spent in each of the phases of an IO are as follows:

  Q2G     |     G2I     |    I2D       |     D2C
----------------------------------------------------------------
2.7745%   0.0118%    48.4153%   48.7983%

[ 2600.266601] Average latency - 7501 microsecs per record
[ 2600.266603] Throughput = 816 records/sec


3) Queue size is 8

The average per-request latency, throughput, and the percentage of
time spent in each of the phases of an IO are as follows:

  Q2G     |     G2I     |    I2D       |     D2C
----------------------------------------------------------------
1.5787%   0.0090%   61.3236%    37.0888%

[ 2827.154532] Average latency - 9415 microsecs per record
[ 2827.154534] Throughput = 856 records/sec


5) Queue size is 10

The average per-request latency, throughput, and the percentage of
time spent in each of the phases of an IO are as follows:

  Q2G     |     G2I     |    I2D       |     D2C
----------------------------------------------------------------
1.2429%   0.0071%    68.9123%   29.8377%

[ 3098.833541] Average latency - 11690 microsecs per record
[ 3098.833544] Throughput = 857 records/sec


6) Queue size is 20

The average per-request latency, throughput, and the percentage of
time spent in each of the phases of an IO are as follows:

  Q2G     |     G2I     |    I2D       |     D2C
----------------------------------------------------------------
0.7845%   0.0035%    83.9879%   15.2241%

[ 3373.895785] Average latency - 23975 microsecs per record
[ 3373.895787] Throughput = 819 records/sec


7) Queue size is 128

The average per-request latency, throughput, and the percentage of
time spent in each of the phases of an IO are as follows:

  Q2G     |     G2I     |    I2D       |     D2C
----------------------------------------------------------------
0.0144%   0.0008%    95.9831%   4.0018%

[ 3832.438315] Average latency - 87495 microsecs per record
[ 3832.438318] Throughput = 854 records/sec

>From the above experiments, we see that when the queue size is very
small, D2C affects the latency the most; however, as we keep
increasing the request_queue size, I2D becomes the deciding factor
(and has a major effect on the latency.) In other words, more the time
taken to issue a request to the SCSI driver, greater is the latency.

The next step which I plan to take is to look at the SCSI subsystem
and identify possible knobs in sysfs that I can use to tailor the
driver to fit our needs and improve performance. Plus, I need to check
if it's possible to flush the request_queue to the driver as soon as a
few requests have been added to it (and not continue to queue up too
many requests causing I2D time to go up.) This, if possible, _might_
help reduce I2D time.

Can someone guide me as to what all SCSI tunables I can make use of
via sysfs? Are there some numbers that I should change which can
affect the performance? Also, since NCQ was enabled on my drive, is
there something I can change in AHCI as well?

Any pointers in this direction would be appreciated! Thank you!

Regards,
Pallav
